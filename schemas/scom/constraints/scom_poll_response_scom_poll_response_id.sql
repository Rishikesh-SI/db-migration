-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_poll_response scom_poll_response_id
-- Type: CONSTRAINT

-- Name: scom_poll_response scom_poll_response_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_poll_response
    ADD CONSTRAINT scom_poll_response_id PRIMARY KEY (poll_response_id);


--
