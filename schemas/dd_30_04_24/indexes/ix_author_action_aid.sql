-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_author_action_aid ON dd_30_04_24.dd_author_action USING btree (author_id);


--
