-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX ix_author_action_aid ON labuww.labuww_author_action USING btree (author_id);


--
