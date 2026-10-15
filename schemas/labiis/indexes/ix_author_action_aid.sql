-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labiis; Owner: -
--

CREATE INDEX ix_author_action_aid ON labiis.labiis_author_action USING btree (author_id);


--
