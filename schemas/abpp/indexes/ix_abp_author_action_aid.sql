-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_author_action_aid
-- Type: INDEX

-- Name: ix_abp_author_action_aid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_author_action_aid ON abpp.abp_author_action USING btree (author_id);


--
