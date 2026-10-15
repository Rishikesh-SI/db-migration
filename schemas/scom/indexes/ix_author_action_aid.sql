-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_author_action_aid ON scom.scom_author_action USING btree (author_id);


--
