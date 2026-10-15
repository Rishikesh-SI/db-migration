-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labmao; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labmao.labmao_user USING btree (email_id);


--
