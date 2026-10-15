-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_poll_option_pid
-- Type: INDEX

-- Name: ix_pkl_poll_option_pid; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_poll_option_pid ON labpkl.labpkl_poll_option USING btree (poll_id);


--
