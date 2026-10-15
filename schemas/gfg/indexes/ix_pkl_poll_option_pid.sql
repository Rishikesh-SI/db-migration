-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_poll_option_pid
-- Type: INDEX

-- Name: ix_pkl_poll_option_pid; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_poll_option_pid ON gfg.gfg_poll_option USING btree (poll_id);


--
