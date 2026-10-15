-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: ix_ttmum_user_activity_aid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aid; Type: INDEX; Schema: labmcfc; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aid ON labmcfc.labmcfc_user_activity USING btree (user_id);


--
