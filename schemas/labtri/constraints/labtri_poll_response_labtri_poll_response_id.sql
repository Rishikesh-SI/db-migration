-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_poll_response labtri_poll_response_id
-- Type: CONSTRAINT

-- Name: labtri_poll_response labtri_poll_response_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_poll_response
    ADD CONSTRAINT labtri_poll_response_id PRIMARY KEY (poll_response_id);


--
