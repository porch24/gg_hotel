<?php

namespace App\Domain\Booking\Repository;

use App\Factory\QueryFactory;
use DomainException;
use Cake\Chronos\Chronos;
use Symfony\Component\HttpFoundation\Session\Session;

final class BookingRepository
{
    private $queryFactory;
    private $session;

    public function __construct(Session $session, QueryFactory $queryFactory)
    {
        $this->queryFactory = $queryFactory;
        $this->session = $session;
    }
    public function insertBooking(array $row): int
    {
        $row['created_at'] = Chronos::now()->toDateTimeString();
        $row['created_user_id'] = $this->session->get('user')["id"];
        $row['updated_at'] = Chronos::now()->toDateTimeString();
        $row['updated_user_id'] = $this->session->get('user')["id"];

        return (int)$this->queryFactory->newInsert('bookings', $row)->execute()->lastInsertId();
    }

    public function insertBookingUser(array $row): int
    {
        $row['booking_date'] = Chronos::now()->toDateTimeString();
        $row['created_at'] = Chronos::now()->toDateTimeString();
        $row['created_user_id'] = $this->session->get('user')["id"];
        $row['updated_at'] = Chronos::now()->toDateTimeString();
        $row['updated_user_id'] = $this->session->get('user')["id"];

        return (int)$this->queryFactory->newInsert('bookings', $row)->execute()->lastInsertId();
    }

    public function updateBooking(int $bookingID, array $data): void
    {
        $data['updated_at'] = Chronos::now()->toDateTimeString();
        $data['updated_user_id'] = $this->session->get('user')["id"];

        $this->queryFactory->newUpdate('bookings', $data)->andWhere(['id' => $bookingID])->execute();
    }

    public function deleteBooking(int $bookingID): void
    {
        $this->queryFactory->newDelete('bookings')->andWhere(['id' => $bookingID])->execute();
    }

    public function findBookings(array $params): array
    {
        $query = $this->queryFactory->newSelect('bookings');
        $query->select(
            [
                'bookings.id',
                'booking_no',
                'book_detail_id',
                'user_id',
                'room_id',
                'payment_id',
                'status',
                'booking_date',
                'bookings.created_at',
                'room_number',
                'room_price',
                'room_type',
                'first_name',
                'last_name',
                'date_in',
                'date_out',
                'check_in',
                'check_out',
                'deposit',
                'amount',
            ]
        ); 
        $query->join([
            'r' => [
                'table' => 'rooms',
                'type' => 'INNER',
                'conditions' => 'r.id = room_id',
            ]
        ]);
        $query->join([
            'u' => [
                'table' => 'users',
                'type' => 'INNER',
                'conditions' => 'u.id = user_id',
            ]
        ]);
        $query->join([
            'bd' => [
                'table' => 'booking_details',
                'type' => 'INNER',
                'conditions' => 'bd.id = book_detail_id',
            ]
        ]);
        $query->join([
            'p' => [
                'table' => 'payments',
                'type' => 'INNER',
                'conditions' => 'p.id = payment_id',
            ]
        ]);
        if (isset($params["check_in"])) {
            $query->andWhere(['date_in' => $params['check_in']]);
        }
        if (isset($params["check_out"])) {
            $query->andWhere(['date_out' => $params['check_out']]);
        }
        if (isset($params["startDate"])) {
            $query->andWhere(['booking_date <=' => $params['endDate'], 'booking_date >=' => $params['startDate']]);
        }
        return $query->execute()->fetchAll('assoc') ?: [];
    }

    public function findBookingsForBooking(array $params): array
    {
        $query = $this->queryFactory->newSelect('bookings');
        $query->select(
            [
                'bookings.id',
                'booking_no',
                'book_detail_id',
                'user_id',
                'room_id',
                'payment_id',
                'status',
                'booking_date',
                'bookings.created_at',
                'room_number',
                'room_price',
                'room_type',
                'date_in',
                'date_out',
                'check_in',
                'check_out',
            ]
        ); 
        $query->join([
            'r' => [
                'table' => 'rooms',
                'type' => 'INNER',
                'conditions' => 'r.id = room_id',
            ]
        ]);
        $query->join([
            'bd' => [
                'table' => 'booking_details',
                'type' => 'INNER',
                'conditions' => 'bd.id = book_detail_id',
            ]
        ]);
        if(isset($params['room_id'])){
            $query->andWhere(['room_id' => $params['room_id']]);
        }
        if(isset($params['room_type'])){
            $query->andWhere(['room_type' => $params['room_type']]);
        }
        if (isset($params["startDate"])) {
            $query->andWhere(['date_in <=' => $params['endDate'], 'date_out >=' => $params['startDate']]);
        }
        $query->andWhere(['status !=' => 'CANCEL']);
        $query->andWhere(['status !=' => 'CHECK_OUT']);
        

        return $query->execute()->fetchAll('assoc') ?: [];
    }

    public function findBookingsForUser(array $params): array
    {
        $query = $this->queryFactory->newSelect('bookings');
        $query->select(
            [
                'bookings.id',
                'booking_no',
                'book_detail_id',
                'user_id',
                'room_id',
                'payment_id',
                'status',
                'booking_date',
                'bookings.created_at',
                'room_number',
                'room_price',
                'room_type',
                'date_in',
                'date_out',
                'check_in',
                'check_out',
                'deposit',
                'amount',
            ]
        ); 
        $query->join([
            'r' => [
                'table' => 'rooms',
                'type' => 'INNER',
                'conditions' => 'r.id = room_id',
            ]
        ]);
        $query->join([
            'bd' => [
                'table' => 'booking_details',
                'type' => 'INNER',
                'conditions' => 'bd.id = book_detail_id',
            ]
        ]);
        $query->join([
            'p' => [
                'table' => 'payments',
                'type' => 'INNER',
                'conditions' => 'p.id = payment_id',
            ]
        ]);
        if (isset($params["startDate"])) {
            $query->andWhere(['date_in <=' => $params['endDate'], 'date_out >=' => $params['startDate']]);
        }
        if(isset($params['booking_id'])){
            $query->andWhere(['bookings.id' => $params['booking_id']]);
        }
        if(isset($params['user_id'])){
            $query->andWhere(['user_id' => $params['user_id']]);
        }
        return $query->execute()->fetchAll('assoc') ?: [];
    }

    public function findBookingsSigleTabel(array $params): array
    {
        $query = $this->queryFactory->newSelect('bookings');
        $query->select(
            [
                'bookings.id',
                'book_detail_id',
                'user_id',
                'room_id',
                'payment_id',
                'status',
                'booking_date',
            ]
        ); 
        if(isset($params['booking_id'])){
            $query->andWhere(['bookings.id' => $params['booking_id']]);
        }
        return $query->execute()->fetchAll('assoc') ?: [];
    }
}
