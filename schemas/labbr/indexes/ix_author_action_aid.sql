-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labbr; Owner: -
--

CREATE INDEX ix_author_action_aid ON labbr.labbr_author_action USING btree (author_id);


--
