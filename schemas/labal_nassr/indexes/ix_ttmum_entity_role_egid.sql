-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: ix_ttmum_entity_role_egid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_egid; Type: INDEX; Schema: labal_nassr; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_egid ON labal_nassr.labal_nassr_entity_role USING btree (entity_group_id);


--
