-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labbsc_old; Owner: -
--

CREATE INDEX ix_author_action_aid ON labbsc_old.labbsc_author_action USING btree (author_id);


--
