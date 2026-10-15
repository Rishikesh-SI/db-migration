-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_poll_option labisp_poll_option_id
-- Type: CONSTRAINT

-- Name: labisp_poll_option labisp_poll_option_id; Type: CONSTRAINT; Schema: labisp; Owner: -
--

ALTER TABLE ONLY labisp.labisp_poll_option
    ADD CONSTRAINT labisp_poll_option_id PRIMARY KEY (poll_option_id);


--
