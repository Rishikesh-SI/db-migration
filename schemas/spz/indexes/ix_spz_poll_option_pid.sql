-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_poll_option_pid
-- Type: INDEX

-- Name: ix_spz_poll_option_pid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_poll_option_pid ON spz.spz_poll_option USING btree (poll_id);


--
