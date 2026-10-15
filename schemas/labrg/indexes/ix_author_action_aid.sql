-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labrg; Owner: -
--

CREATE INDEX ix_author_action_aid ON labrg.labrg_author_action USING btree (author_id);


--
