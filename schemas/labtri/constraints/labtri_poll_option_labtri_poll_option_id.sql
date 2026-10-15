-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_poll_option labtri_poll_option_id
-- Type: CONSTRAINT

-- Name: labtri_poll_option labtri_poll_option_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_poll_option
    ADD CONSTRAINT labtri_poll_option_id PRIMARY KEY (poll_option_id);


--
