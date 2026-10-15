-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_author_action_aid ON gsf.gsf_author_action USING btree (author_id);


--
