-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labilt; Owner: -
--

CREATE INDEX ix_author_action_aid ON labilt.labilt_author_action USING btree (author_id);


--
