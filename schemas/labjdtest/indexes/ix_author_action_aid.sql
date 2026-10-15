-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labjdtest; Owner: -
--

CREATE INDEX ix_author_action_aid ON labjdtest.labjdtest_author_action USING btree (author_id);


--
