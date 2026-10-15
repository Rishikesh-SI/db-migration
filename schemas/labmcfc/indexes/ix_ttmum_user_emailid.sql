-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labmcfc; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labmcfc.labmcfc_user USING btree (email_id);


--
