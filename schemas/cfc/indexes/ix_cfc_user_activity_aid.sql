-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_user_activity_aid
-- Type: INDEX

-- Name: ix_cfc_user_activity_aid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_user_activity_aid ON cfc.cfc_user_activity USING btree (user_id);


--
