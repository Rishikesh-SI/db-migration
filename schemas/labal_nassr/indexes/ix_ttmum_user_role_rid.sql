-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: ix_ttmum_user_role_rid
-- Type: INDEX

-- Name: ix_ttmum_user_role_rid; Type: INDEX; Schema: labal_nassr; Owner: -
--

CREATE INDEX ix_ttmum_user_role_rid ON labal_nassr.labal_nassr_user_role USING btree (role_id);


--
