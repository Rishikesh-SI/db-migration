-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_user_role_rid
-- Type: INDEX

-- Name: ix_abp_user_role_rid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_user_role_rid ON abpp.abp_user_role USING btree (role_id);


--
