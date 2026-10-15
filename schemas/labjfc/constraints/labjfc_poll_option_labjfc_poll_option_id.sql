-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_poll_option labjfc_poll_option_id
-- Type: CONSTRAINT

-- Name: labjfc_poll_option labjfc_poll_option_id; Type: CONSTRAINT; Schema: labjfc; Owner: -
--

ALTER TABLE ONLY labjfc.labjfc_poll_option
    ADD CONSTRAINT labjfc_poll_option_id PRIMARY KEY (poll_option_id);


--
