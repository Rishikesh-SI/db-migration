-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_poll_option_pid
-- Type: INDEX

-- Name: ix_scom_poll_option_pid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_poll_option_pid ON scom.scom_poll_option USING btree (poll_id);


--
