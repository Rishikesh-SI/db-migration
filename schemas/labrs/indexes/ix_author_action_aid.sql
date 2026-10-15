-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labrs; Owner: -
--

CREATE INDEX ix_author_action_aid ON labrs.labrs_author_action USING btree (author_id);


--
