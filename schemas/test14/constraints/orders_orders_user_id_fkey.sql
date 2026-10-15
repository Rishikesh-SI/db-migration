-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: test14
-- Object: orders orders_user_id_fkey
-- Type: FK CONSTRAINT

-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: test14; Owner: -
--

ALTER TABLE ONLY test14.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES test14.users(user_id);


--
