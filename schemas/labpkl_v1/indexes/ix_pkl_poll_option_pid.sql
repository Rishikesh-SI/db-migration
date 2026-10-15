-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_poll_option_pid
-- Type: INDEX

-- Name: ix_pkl_poll_option_pid; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_poll_option_pid ON labpkl_v1.labpkl_v1_poll_option USING btree (poll_id);


--
