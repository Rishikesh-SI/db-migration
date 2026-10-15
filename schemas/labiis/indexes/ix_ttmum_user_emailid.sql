-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labiis; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labiis.labiis_user USING btree (email_id);


--
