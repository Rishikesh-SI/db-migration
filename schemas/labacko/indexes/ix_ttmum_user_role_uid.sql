-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: ix_ttmum_user_role_uid
-- Type: INDEX

-- Name: ix_ttmum_user_role_uid; Type: INDEX; Schema: labacko; Owner: -
--

CREATE INDEX ix_ttmum_user_role_uid ON labacko.labacko_user_role USING btree (user_id);


--
