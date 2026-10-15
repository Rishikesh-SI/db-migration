-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labisp.labisp_user USING btree (email_id);


--
