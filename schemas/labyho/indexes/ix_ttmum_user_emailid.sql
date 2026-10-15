-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labyho.labyho_user USING btree (email_id);


--
