-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labukk; Owner: -
--

CREATE INDEX ix_author_action_aid ON labukk.labukk_author_action USING btree (author_id);


--
