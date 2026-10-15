-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labacko; Owner: -
--

CREATE INDEX ix_author_action_aid ON labacko.labacko_author_action USING btree (author_id);


--
