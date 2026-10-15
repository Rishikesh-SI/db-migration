-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_poll_option_poll_id_idx
-- Type: INDEX

-- Name: labbsc_dev_poll_option_poll_id_idx; Type: INDEX; Schema: labbsc_dev; Owner: -
--

CREATE INDEX labbsc_dev_poll_option_poll_id_idx ON labbsc_dev.labbsc_dev_poll_option USING btree (poll_id);


--
