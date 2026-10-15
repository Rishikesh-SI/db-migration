-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labadkr; Owner: -
--

CREATE INDEX ix_author_action_aid ON labadkr.labadkr_author_action USING btree (author_id);


--
