-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_poll labpc_poll_id
-- Type: CONSTRAINT

-- Name: labpc_poll labpc_poll_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_poll
    ADD CONSTRAINT labpc_poll_id PRIMARY KEY (poll_id);


--
