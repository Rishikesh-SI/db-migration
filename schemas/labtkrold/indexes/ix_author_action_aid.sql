-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkrold
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labtkrold; Owner: -
--

CREATE INDEX ix_author_action_aid ON labtkrold.labtkr_author_action USING btree (author_id);


--
