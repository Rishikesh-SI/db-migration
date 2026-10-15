-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_author_action_aid ON stn.stn_author_action USING btree (author_id);


--
