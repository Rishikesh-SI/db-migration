-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labacko; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labacko.labacko_user USING btree (email_id);


--
