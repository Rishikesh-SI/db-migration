-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_author_action_aid ON labisp.labisp_author_action USING btree (author_id);


--
