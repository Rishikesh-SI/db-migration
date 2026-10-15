-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: ix_labrao_web_user_clientidsocid
-- Type: INDEX

-- Name: ix_labrao_web_user_clientidsocid; Type: INDEX; Schema: labmao; Owner: -
--

CREATE INDEX ix_labrao_web_user_clientidsocid ON labmao.labmao_web_user USING btree (social_id, client_id) WHERE (social_id IS NOT NULL);


--
