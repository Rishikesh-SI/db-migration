-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_author_action_author_id_idx
-- Type: INDEX

-- Name: labbsc_dev_author_action_author_id_idx; Type: INDEX; Schema: labbsc_dev; Owner: -
--

CREATE INDEX labbsc_dev_author_action_author_id_idx ON labbsc_dev.labbsc_dev_author_action USING btree (author_id);


--
