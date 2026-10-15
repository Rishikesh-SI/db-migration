-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_poll scom_poll_id
-- Type: CONSTRAINT

-- Name: scom_poll scom_poll_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_poll
    ADD CONSTRAINT scom_poll_id PRIMARY KEY (poll_id);


--
