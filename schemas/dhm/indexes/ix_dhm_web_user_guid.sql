-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_dhm_web_user_guid
-- Type: INDEX

-- Name: ix_dhm_web_user_guid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE UNIQUE INDEX ix_dhm_web_user_guid ON dhm.dhm_web_user USING btree (user_guid);


--
