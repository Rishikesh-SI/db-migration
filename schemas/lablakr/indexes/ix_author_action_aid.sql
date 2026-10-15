-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: lablakr; Owner: -
--

CREATE INDEX ix_author_action_aid ON lablakr.lablakr_author_action USING btree (author_id);


--
