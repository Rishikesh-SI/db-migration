-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_author_action_aid ON labstlz.labstlz_author_action USING btree (author_id);


--
