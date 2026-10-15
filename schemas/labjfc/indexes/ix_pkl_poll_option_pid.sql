-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_poll_option_pid
-- Type: INDEX

-- Name: ix_pkl_poll_option_pid; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_poll_option_pid ON labjfc.labjfc_poll_option USING btree (poll_id);


--
