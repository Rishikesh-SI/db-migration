-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_poll_response labisp_poll_response_id
-- Type: CONSTRAINT

-- Name: labisp_poll_response labisp_poll_response_id; Type: CONSTRAINT; Schema: labisp; Owner: -
--

ALTER TABLE ONLY labisp.labisp_poll_response
    ADD CONSTRAINT labisp_poll_response_id PRIMARY KEY (poll_response_id);


--
