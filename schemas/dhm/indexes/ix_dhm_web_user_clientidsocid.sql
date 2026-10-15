-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_dhm_web_user_clientidsocid
-- Type: INDEX

-- Name: ix_dhm_web_user_clientidsocid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_dhm_web_user_clientidsocid ON dhm.dhm_web_user USING btree (social_id, client_id) WHERE (social_id IS NOT NULL);


--
