-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labtkr; Owner: -
--

CREATE INDEX ix_author_action_aid ON labtkr.labtkr_author_action USING btree (author_id);


--
