-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labgsoc; Owner: -
--

CREATE INDEX ix_author_action_aid ON labgsoc.labgsoc_author_action USING btree (author_id);


--
