-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_author_action_aid
-- Type: INDEX

-- Name: ix_zeven_author_action_aid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_author_action_aid ON zeven.zeven_author_action USING btree (author_id);


--
